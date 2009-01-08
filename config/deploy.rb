set :runner, "mattt"
set :use_sudo, false

# =============================================================================
# CUSTOM OPTIONS
# =============================================================================
set :user,        "capistrano"
set :application, "fullboat"
set :domain,      "eleven.wrct.org"
set :alias,       %{ fullboat.wrct.org }

role :web, domain
role :app, domain
role :db,  domain, :primary => true

# =============================================================================
# DATABASE OPTIONS
# =============================================================================
set :rails_env,  "production"

# =============================================================================
# DEPLOY TO
# =============================================================================
set :deploy_to,   "/var/www/#{application}"

# =============================================================================
# REPOSITORY
# =============================================================================
set :scm,        :git
set :deploy_via, :remote_cache 
set :repository, "git://github.com/mattt/fullboat.git"

# =============================================================================
# SSH OPTIONS
# =============================================================================

# default_run_options[:pty] = true
# ssh_options[:paranoid] = false
# ssh_options[:keys] = %w(/Users/mattt/.ssh/id_rsa)
# ssh_options[:port] = 1600