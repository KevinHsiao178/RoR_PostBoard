#上傳至Heroku遇到的問題：#
##1. 若是使用公司網路，有可能會被擋##
我是在執行```heroku run rake db:migrate```時出現：
```socket hang up```
所以大家如果遇到一樣的問題可以先換到別的網路試試

##2. Migration file的順序問題##
我的Rails專案內有user, articles, comments三個資源，當初先分別建立articles, comments，後來才又加上users，並且在atticles與comments的migration file加上
```ruby
t.references :user, index: true, foreign_kay: true
```
這樣會導致```heroku run rake db:migrate```時出現錯誤(但在開發時是可以正常```rake db:migrate```)

**Root cause:** 因為以先後順序來看分別為articles, comments再來是users，所以當Heroku在```heroku run rake db:migrate```第一個migration file(也就是articles)會找不到user這個資源；所以當我將users調到第一個file的話(把users的migration file名稱timestamp改在articles與comments之前)，然後再```heroku run rake db:migrate```就可以正常執行了(記得要先commit, push到github)，因為它會先執行users再來articles最後comments；

**這個狀況是會發生在不同tabel間有relation的情況時會發生，並且有上下的關係，所以基本上建立migration file的順序要從最上層的table開始建**
