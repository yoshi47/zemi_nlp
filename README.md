# 日本語単語ベクトルの比較評価

## BERTモデルのダウンロード
Google Drive の [bert-wiki-ja](https://drive.google.com/drive/folders/1Zsm9DD40lrUVu6iAnIuTH2ODIkh-WM-O "bert-japanese") フォルダをダウンロードして、`model/bert/` に解凍する。

### 解凍後のディレクトリ構成
```
work
├── data
├── evaluate_dataset
├── model
│   └── bert
│       ├── config.json
│       ├── graph.pbtxt
│       ├── model.ckpt-1400000.data-00000-of-00001
│       ├── model.ckpt-1400000.index
│       ├── model.ckpt-1400000.meta
│       ├── wiki-ja.model
│       └── wiki-ja.vocab
...
```

## Dcokerを使った環境構築

``` bash
docker compose up -d
```

[localhost:8888](http://localhost:8888/lab) にアクセスすると、JupyterLabが起動する。

