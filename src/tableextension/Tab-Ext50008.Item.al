tableextension 50008 Item extends Item
{
    fields
    {
        field(56601; "Item G/L Budget Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(56602; "Is Controlled"; Boolean)
        {

        }
        field(88888; "Control Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));

        }  //"Product Class"
        field(88889; "Production  Area"; Option)
        {
            OptionCaption = ' ,Kitchen,Location a,Location b';
            OptionMembers = " ",Kitchen,"Location a","Location b";
            DataClassification = ToBeClassified;
        }
        field(88890; "Product Class"; Option)
        {
            OptionCaption = ' ,Drinks,Breakfast,Snacks,Main Meal';
            OptionMembers = " ",Drinks,Breakfast,Snacks,"Main Meal";
            DataClassification = ToBeClassified;
        }
        field(88891; "Control Category"; Option)
        {
            OptionCaption = '" ","500 CUP","500 BOTTLE","250 CUP","150 CUP","CRATES","CANS"';
            OptionMembers = " ","500 CUP","500 BOTTLE","250 CUP","150 CUP","CRATES","CANS";
        }
        field(88892; "Expiry Window"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(88893; "Credit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88894; "POS Unit of Measure"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(88895; "POS Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88896; "BarCode No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        // field(88897; "Product Group Code"; code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }	
        field(88897; "Item Category"; enum "Item Category")
        {
            Caption = 'Item Category';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Category"."Item Category Type" where(Code = field("Item Category Code")));
        }
        field(88898; "Game Code"; Code[20])
        {
            Caption = 'Game Code';
            TableRelation = Game;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Game: Record "Game";
            begin
                if Game.Get("Game Code") then
                    "Game Name" := Game."Name";
            end;
        }
        //."Game Name"
        field(88899; "Game Name"; Text[250])
        {
            Caption = 'Game Name';
            DataClassification = CustomerContent;
        }
        field(88900; "Drug Category"; Option)
        {
            OptionMembers = Pharmacitical,"Non-Pharmaciticals","Lab Reagents";
            Caption = 'Drug Category';
            DataClassification = CustomerContent;
        }
        field(88901; "Reorder Threshold"; Integer)
        {
            Caption = 'Reorder Threshold';
            DataClassification = CustomerContent;
        }
        field(88902; "Unit of measure"; Code[56])
        {
            Caption = 'Unit of measure';
            DataClassification = CustomerContent;
            TableRelation="Unit of Measure";
        }
        field(88903; "SequenceNo"; Integer)
        {
            Caption = 'SequenceNo';
            DataClassification = CustomerContent;
        }
    }
}