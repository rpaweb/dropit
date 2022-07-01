# README

Step by step to initiate with the DropIt app.
1. "bundle", to make the correct installation of all the gems.
2. "rails db:migrate", to run all the migrations.
3. You'll need to google credentials to make a correct run of the Google SSO (Omniauth). Make a ".env" file and associate the variables "GOOGLE_OAUTH_CLIENT_ID" and "GOOGLE_OAUTH_CLIENT_SECRET" to credentials of your own.
4. Have fun posting, importing multiple posts, following people, and more.

Note: If you want to upload multiple posts from file, you'll need to fill data in a CSV file like the located in the root folder of this app.