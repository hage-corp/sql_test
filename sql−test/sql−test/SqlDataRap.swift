//
//  SqlDataRap.swift
//  sql−test
//
//  Created by NishiwakiHajime on 2015/04/23.
//  Copyright (c) 2015年 NishiwakiHajime. All rights reserved.
//

import Foundation

// SQL操作の為のモデル

class SqlDataRap {
    //
    // コンストラクタ
    init(){
        if(!self.isExistsDataBase()){
            // テーブルがなかったら作る
            let(result, msg) = self.create_basic_tables();
        }
        println(SwiftData.databasePath())
    }
    
    //  テーブルの存在確認
    func isExistsDataBase() ->Bool{
        let (tb, err) = SwiftData.existingTables();
        
        // identifyのテーブルがあるか
        if(!contains(tb,"identify")){
            //  identifyがない
            println(" no table!!!! ")
            return false;
        }else{
            let sql = "Select * from identify";
            let (resultSet, err) = SwiftData.executeQuery(sql);
            println(resultSet)

            return true;
        }
        
    }
    
    // テーブルを作る
    func create_basic_tables() ->(Bool, String){
        
        //  identifyを作る
        // 名前　StringVal　年　IntVal　作成　DataVal
        if let err = SwiftData.createTable("identify", withColumnNamesAndTypes: ["name" : .StringVal, "age":.IntVal, "created_on":.DateVal]){
            //  エラー発生
            println(SwiftData.errorMessageForCode(err));
            return(false, "error ocured in creating identify");
        }
        
        return (true,"schema initialize succeeded");
    }
    
    // nameを受け取ってinsertするメソッド
    func Add(title_in :String) ->Bool{
        // sqlを準備
        let sql = "INSERT INTO identify (name, age, created_on) VALUES (?, 0, current_date)";
        
        // ?に入る変数をバインドして実行 - 年は0歳で
        if let err = SwiftData.executeChange( sql, withArgs: [title_in]) {
            //エラーが発生した時の処理
            let msg = SwiftData.errorMessageForCode(err);
            println(msg)
            return false;
        } else {
            return true;
        }
    }
    
    //  データを全件抜き出してdictionaryの配列で返す
    func SelectAll() -> NSMutableArray /*[Dictionary<String, String>]*/{
        let sql = "Select * from identify";
        //var result: [Dictionary<String, String>] = [];
        var result = NSMutableArray()
        
        // Dataはフォーマッターを使用する
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
    
        // ＊＊select分は必ずexecuteQueryを使う＊＊
        let (resultSet, err) = SwiftData.executeQuery(sql);
        if err != nil {
            //there was an error during the query, handle it here
            var msg = SwiftData.errorMessageForCode(err!);
            println(msg)
    
        } else {
            // resultSet分ループを回す
            for row in resultSet {
                if let id = row["ID"]?.asInt() {
                    //  取得したリザルトセットからデータを抜き出して配列に追加していく
                    var name:String? = row["name"]?.asString()
                    var id:Int? = row["ID"]?.asInt()
                    var age:Int? = row["age"]?.asInt()
                    var dataStr = row["created_on"]?.asString()!
                    dateFormatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
                    //var data = dateFormatter.dateFromString(dataStr!)
    
                    // この下はディクショナリーで登録する場合
                    //result.append(["name":name!, "ID":String(id!)])
                    
                    // この下はNSMutableArrayで登録する場合
                    var dic = ["ID":id!, "name":name!, "age":age!, /*"data":data!*/]
                    result.addObject(dic)
                }
            }
        }
        return result;
    }
    
    // 指定されたIDの行を削除します
    func delete(id:Int) -> Bool {
        if let err = SD.executeChange("DELETE FROM identify WHERE ID = ?", withArgs: [id]) {
            //there was an error during the insert, handle it here
            return false
        } else {
            //no error, the row was inserted successfully
            return true
        }
    }
}

