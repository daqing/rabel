# 发布到 Heroku

## 设置环境变量

拷贝 `config/application.example.yml` 到 `config/application.yml`
按需替换其中的变量

> 其中 `SECRET_TOKEN` 用 `$ rake secret` 来替换

## 发布

### Push

```bash
$ git push heroku
```

### 设置数据库

```bash
$ heroku run:rake 'db:setup'
```

### 把环境变量发布到 Heroku

```bash
$ rake figaro:heroku
```

### 安装 memcache 插件:

```bash
$ heroku addons:add memcache
```

