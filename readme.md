### Step 1, New a project

```
rails new demo
```

### Step 2, Update Gemfile

add paperclip, mysql2 gem, enable JavaScript runtime

```
gem 'mysql2'
gem 'paperclip'
gem 'therubyracer', platforms: :ruby // remove the comment
```

You should be able to run rails server now:
```
ang@ubuntuChef:/opt/ruby/demo$ rails server
=> Booting WEBrick
=> Rails 4.0.3 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2014-02-27 18:39:15] INFO  WEBrick 1.3.1
[2014-02-27 18:39:15] INFO  ruby 2.1.1 (2014-02-24) [x86_64-linux]
[2014-02-27 18:39:15] INFO  WEBrick::HTTPServer#start: pid=3187 port=3000
```

### Step 3, Creating the Database

```
ang@ubuntuChef:/opt/ruby/demo$ rails generate scaffold User username:string avator:add_attachment download:add_attachment
```

Your migration file looks like:
```
ang@ubuntuChef:/opt/ruby/demo$ less db/migrate/20140227235934_create_users.rb

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.timestamps
    end
  end
end
```

add paperclip  - one is image, one is zip file

```
ang@ubuntuChef:/opt/ruby/demo$ rails generate paperclip User avator download

ang@ubuntuChef:/opt/ruby/demo$ vim db/migrate/20140228000158_add_attachment_avator_download_to_users.rb
class AddAttachmentAvatorDownloadToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :avator
      t.attachment :download
    end
  end
  def self.down
    drop_attached_file :users, :avator
    drop_attached_file :users, :download
  end
end
```
 

### Step 4, Applying the Migration - there are two migrations.

```
ang@ubuntuChef:/opt/ruby/demo$ rake db:migrate
==  CreateUsers: migrating ====================================================
-- create_table(:users)
   -> 0.0196s
==  CreateUsers: migrated (0.0199s) ===========================================
==  AddAttachmentAvatorDownloadToUsers: migrating =============================
-- change_table(:users)
   -> 0.2719s
==  AddAttachmentAvatorDownloadToUsers: migrated (0.2721s) ====================
```

### Step 5, Start server

http://192.168.88.216:3000/users/new

You will see the new user page, but no file upload options. We need to add them manually.

### Step 6, update model

```
ang@ubuntuChef:/opt/ruby/demo$ vim app/models/user.rb

class User < ActiveRecord::Base
  has_attached_file :avator
  has_attached_file :download
  validates_attachment_content_type :avator, :content_type => %w(image/jpeg image/jpg image/png application/pdf)
  validates_attachment_content_type :download, :content_type => %w(application/octet-stream  application/x-zip application/x-zip-compressed application/pdf application/x-pdf)
end
```

### Step 7, update view

```
ang@ubuntuChef:/opt/ruby/demo$ vim app/views/users/_form.html.erb
  <div class="field">
    <%= f.label :avator %><br>
    <%= f.file_field :avator %>
  </div>
  <div class="field">
    <%= f.label :download %><br>
    <%= f.file_field :download %>
  </div>
```

```
ang@ubuntuChef:/opt/ruby/demo$ vim app/views/users/show.html.erb
<p>
  <strong>Avator:</strong>
 <%= image_tag @user.avator.url %>
<%= image_tag @user.avator.url(:thumb) %>
</p>
<p>
  <strong>Download:</strong>
  <a href="<%= @user.download.url %>" > Download File </a>
</p>
```

### Step 8, update controller

```
ang@ubuntuChef:/opt/ruby/demo$ vim app/controllers/users_controller.rb

    def user_params
      params.require(:user).permit(:username, :avator , :download)
    end
```

### Step 9
```
Run server:

ang@ubuntuChef:/opt/ruby/demo$ rails server
```

