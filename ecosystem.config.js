module.exports = {
    apps: [
      {
        name: 'calendar',
        script: 'bundle',
        args: 'exec rails server -p 3000 -b 0.0.0.0',
        env: {
          RAILS_ENV: 'production'
        }
      }
    ]
  };
  