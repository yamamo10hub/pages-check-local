# jekyll for github-pages preview
  
## 概要
github pagesをpush前にlocalで表示確認したい  
jekyllをlocalhost:4000で起動できるコンテナ  
  
## 使い方
表示テストしたいmarkdownファイルを./src/に設置する  
  
./Gemfile を./src/に追加する  
  
./_config.ymlを./src/に追加する  
```
このファイルはgithubpagesで使うものとは異なる  
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
* 一時的な確認目的なら-dは付けないことが多いかもしれない  
  
index.mdが存在すれば、localhost:4000でコンテンツが表示される  
indexが無ければ、置いたファイル.htmlで表示できる  
  
## 編集作業
./src/ でコンテンツの変更を行うと、コンテナは勝手にreloadを行う  
ブラウザ側もreloadすれば表示が反映されるはず  
  
## 停止、かたずけ
ctrl+cやdocker-compose down -vで止める  
dockerimageも消す  
```
docker rmi jekyll-githubpages
```
./src/の中身をpagesに上げる場合、以下のファイルは抜いた方がよい  
```
.gitkeep, _config.yml, Gemfile, Gemfile.lock
```
特に_config.ymlは本来のgithubpages用に同名のファイルがあるはずなので上書きに注意する  
  
## 副産物
docker-compose.yamlのvolumesで
```
- ./dst:/srv/jekyll
```
とするとjykellが変換したhtmlコンテンツとsrcのmarkdownファイルが./dstに生成される  
  
生成されたhtmlファイルはそのまま抜いてもその他webサーバーでは使えない  
githubpagesと互換表示するためのpluginを入れたせいで以下の問題がある  
* githubのレポジトリ名がリンクで埋め込まれる  
* CSSを認識しない  
  
なので、markdownファイルを一般ウェブサーバー向けに変換したければ、githubプラグインを入れない  
jykellコンテナを別に作成する必要がある  
  
以上からこのコンテナはgithubpagesへpushする前に表示を確認できるものでしかない  
  