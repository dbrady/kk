# before running this, ensure that DB refers to the database we wanna modify...

DB.create_table :entries do
  primary_key :id
  String :title
  String :body, text: true
  DateTime :entered_at
  DateTime :created_at
  DateTime :updated_at

  index :entered_at
end
