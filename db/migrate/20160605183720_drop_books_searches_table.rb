class DropBooksSearchesTable < ActiveRecord::Migration
    def up
        drop_table :Books_Searches
    end

    def down
        raise ActiveRecord::IrreversibleMigration
    end
end
