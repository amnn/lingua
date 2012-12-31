class AddDefaultsToTables < ActiveRecord::Migration

    def self.up

        change_column_default( :words, :freq,  0 )
        change_column_default( :users, :stars, 0 )

        User.update_all(             :stars => 0 )

    end

    def self.down

        change_column_default( :words, :freq,  nil )
        change_column_default( :users, :stars, nil )

    end

end
