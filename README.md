# jekyll for github-pages preview
jekyllをlocalhost:4000で起動できるコンテナである  
  
## 概要
このgitには２つの目的が混ざってしまっている  
1. githubpagesにpushする前に表示を確認できる環境が欲しい  
2. markdownで作成されたコンテンツを良い感じに変換したい  
  
途中でjekyllの本来の用途を理解し２が欲しくなった  
よって1の用途だけであれば要らないディレクトリなどがついている  
  
## 使い方
表示テストしたいmarkdownファイルを./src/に設置する  
  
./Gemfile を./src/に追加する  
  
./_config.ymlを./src/に追加する  
```
このファイルはgithubpagesで使うものとは異なるので.gitignoreで管理した方がよい  
```
  
composeで使うimageファイルをbuildする
```
docker build -t jekyll-githubpages 
docker images
```
  
```
docker-compose up 
```
* -dつけてもよいがログ出力は無くなる  
* 一時的な確認目的なら-dは要らないはず  
  
index.mdが存在すれば、localhost:4000でコンテンツが表示される  
無ければ置いたファイル.htmlで表示できる  
  
## 編集作業
./src/ でコンテンツの変更を行うと、コンテナが勝手にreloadしてくれる  
ブラウザでreloadすれば表示が反映されるはず  
  
## 停止、かたずけ
ctrl+cやdocker-compose down -vで止める  
./src/の中身をpagesに上げる場合、以下のファイルは抜いた方がよい  
```
.gitkeep, _config.yml, Gemfile, Gemfile.lock
```
  
## 副産物
docker-compose.yamlのvolumesで
- ./dst:/srv/jekyll
とするとjykellが変換したhtmlコンテンツとsrcのmarkdownファイルが./dstに生成される  
が次の問題点がある  
  
副産物として作成されたhtmlファイルはそのまま抜いてもその他webサーバーでは使えない  
githubpagesと互換表示するためのpluginを入れたせいで以下の問題がある  
* githubのレポジトリ名がリンクで埋め込まれる  
* CSSを認識しない  
  
なので、markdownファイルを一般ウェブサーバー向けに変換したければ、githubプラグインを入れない  
jykellコンテナを別に作成する必要がある  
  
以上からこのコンテナはgithubpagesへpushする前に表示を確認できるもの、でしかない。  
  