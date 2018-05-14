namespace :load do
  task :defaults do
    set :kemal_pid, -> { File.join(shared_path, 'kemal.pid') }
    set :kemal_file, 'src/app.cr'
    set :kemal_app, 'app'
    set :kemal_env, 'development'
    set :kemal_log_file, 'kemal.log'
  end
end

namespace :deploy do
  after :updated, :build do
    on roles(:web) do
      within release_path do
        execute :shards, "install --production"
        execute :crystal, "build --release #{fetch(:kemal_file)}"
      end
    end
  end
end

namespace :kemal do
  task :start do
    on roles(:web) do
      within release_path do
        with kemal_env: fetch(:kemal_env) do
          execute "./#{fetch(:kemal_app)}".to_sym, "&>> #{fetch(:kemal_log_file)} & echo $! > #{fetch(:kemal_pid)}"
        end
      end
    end
  end

  task :restart do
    on roles(:web) do
      invoke 'kemal:stop'
      invoke 'kemal:start'
    end
  end

  task :stop do
    on roles(:web) do
      execute "test -f #{fetch(:kemal_pid)} && kill -INT $(cat #{fetch(:kemal_pid)}) && rm #{fetch(:kemal_pid)} || echo Not running"
    end
  end
end
