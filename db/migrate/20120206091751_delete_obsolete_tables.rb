class DeleteObsoleteTables < ActiveRecord::Migration
  def change
    drop_table :slugs
    drop_table :wiki_page_attachments
    drop_table :wiki_page_versions
    drop_table :wiki_pages
  end
end
