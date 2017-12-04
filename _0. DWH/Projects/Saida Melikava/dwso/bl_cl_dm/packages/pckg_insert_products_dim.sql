Create Or Replace Package Pckg_Insert_Products_Dim
As
  Procedure Insert_Bl_Cls;
  Procedure Insert_Bl_Dim;
End Pckg_Insert_Products_Dim;
/
Create Or Replace Package Body Pckg_Insert_Products_Dim
As
Procedure Insert_Bl_Cls
Is
Begin
Execute Immediate 'TRUNCATE TABLE bl_cl_dm.dim_cl_products';
  Insert
  Into Dim_Cl_Products
  Select Prod_Id,
    Prod_Code,
    Category_Name,
    Prod_Name,
    Prod_Author_Id,
    Author_Name,
    Prod_Description,
    Prod_Genre_Id,
    Genre_Name,
    Prod_Weight_Kg
  From Bl_3nf.Ce_Catalog Ce
  Inner Join Bl_3nf.Ce_Categories Cat
  On Cat.Category_Id=Ce.Prod_Category_Id
  Inner Join Bl_3nf.Ce_Authors Auth
  On Auth.Author_Id=Ce.Prod_Author_Id
  Inner Join Bl_3nf.Ce_Genres G
  On G.Genre_Id=Ce.Prod_Genre_Id
WHERE prod_id>0;
  Dbms_Output.Put_Line('Data in the table is successfully loaded: '||Sql%Rowcount|| ' rows were inserted.');
  Commit;
Exception
When Others Then
  Raise;


End;
Procedure Insert_Bl_Dim
Is
Begin
  Merge Into Bl_Dm.Dim_Products Dim Using
  (Select Product_3nf_Id,
    Product_Code,
    Product_Category_Name,
    Product_Name,
    Product_Author_Id,
    Product_Author,
    Product_Description,
    Product_Genre_Id,
    Product_Genre,
    Product_Weight_Kg
  From Dim_Cl_Products
  Minus
  Select Product_3nf_Id,
    Product_Code,
    Product_Category_Name,
    Product_Name,
    Product_Author_Id,
    Product_Author,
    Product_Description,
    Product_Genre_Id,
    Product_Genre,
    Product_Weight_Kg
  From Bl_Dm.Dim_Products
  ) Cls On ( Cls.Product_3nf_Id = Dim.Product_3nf_Id )
When Matched Then
  Update
  Set Dim.Product_Category_Name= Cls.Product_Category_Name,
    Dim.Product_Name           =Cls.Product_Name,
    Dim.Product_Author_Id      = Cls.Product_Author_Id,
    Dim.Product_Author         =Cls.Product_Author,
    Dim.Product_Description    =Cls.Product_Description,
    Dim.Product_Genre_Id       = Cls.Product_Genre_Id,
    Dim.Product_Genre          =Cls.Product_Genre,
    Dim.Product_Weight_Kg      = Cls.Product_Weight_Kg,
    Dim.Update_Dt              =Trunc(Sysdate) When Not Matched Then
  Insert
    (
      Product_Sur_Id,
      Product_3nf_Id,
      Product_Code,
      Product_Category_Name,
      Product_Name,
      Product_Author_Id,
      Product_Author,
      Product_Description,
      Product_Genre_Id,
      Product_Genre,
      Product_Weight_Kg
    )
    Values
    (
      Seq_Prod_Dim.Nextval,
      Cls.Product_3nf_Id,
      Cls.Product_Code,
      Cls.Product_Category_Name,
      Cls.Product_Name,
      Cls.Product_Author_Id,
      Cls.Product_Author,
      Cls.Product_Description,
      Cls.Product_Genre_Id,
      Cls.Product_Genre,
      Cls.Product_Weight_Kg
    ) ;
     Dbms_Output.Put_Line('Data in the tables is successfully merged: '||Sql%Rowcount|| ' rows were inserted.');
Exception
When Others Then
  Raise;
  Commit;
End;
End Pckg_Insert_Products_Dim;
/
