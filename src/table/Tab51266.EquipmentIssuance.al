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
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("Item No.") then
                    "Item Description" := Item.Description;
                    "Game Code" := Item."Game Code";
                    "Game Name" := Item."Game Name";

            end;
        }
        field(3; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
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
        field(10; "Receipient No."; Code[20])
        {
            Caption = 'Receipient No.';
            TableRelation = if ("User Type" = const(Student)) Customer where("Customer Type" = const(Student)) else if ("User Type" = const(Staff)) "HRM-Employee C" where(Status = const(Active));
            trigger OnValidate()
            var
                Customer: Record Customer;
                Employee: Record "HRM-Employee C";
            begin
                if "User Type" = "User Type"::Student then
                    if Customer.Get("Receipient No.") then
                        "Receipient Name" := Customer.Name
                    else if "User Type" = "User Type"::Staff then
                        if Employee.Get("Receipient No.") then
                            "Receipient Name" := Employee.FullName();
            end;
        }
        field(11; "Receipient Name"; Text[250])
        {
            Caption = 'Receipient Name';
        }
        //"Item Description"
        field(12; "Item Description"; Text[250])
        {
            Caption = 'Item Description';
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
