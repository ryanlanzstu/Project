module.exports = {
  apps: [
    {
      name: "calendar",
      script: "bundle",
      args: "exec rails server -b 0.0.0.0 -p 3000",
      env: {
        RAILS_ENV: "production"
      }
    }
  ]
};
