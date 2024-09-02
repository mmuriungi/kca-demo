// Table: Equipment Issuance
table 51266 "Equipment Issuance"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item where("Item Category" = const("Sporting Equipment"));
        }
        field(3; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
        }
        field(4; "User Type"; Option)
        {
            Caption = 'User Type';
            OptionMembers = Student,Staff;
        }
        field(5; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Return Date';
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Issued,Returned,Lost;
        }
        //Game Code
        field(8; "Game Code"; Code[20])
        {
            Caption = 'Game Code';
            TableRelation = Game;
            trigger OnValidate()
            var
                Game: Record "Game";
            begin
                if Game.Get("Game Code") then
                    "Game Name" := Game."Name";
            end;
        }
        //Game Name
        field(9; "Game Name"; text[250])
        {
            Caption = 'Game Name';
        }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
