table 50087 "Workplan Activities"
{
    DataCaptionFields = "Activity Code", "Workplan Code";
    DrillDownPageID = "Workplan Activities";
    LookupPageID = "Workplan Activities";

    fields
    {
        field(1; "Activity Code"; Code[20])
        {
            Caption = 'Activity Code';
        }
        field(2; "Activity Description"; Text[250])
        {
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";
        }
        field(4; Indentation; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
        }
        field(5; Totaling; Text[250])
        {
            Caption = 'Totaling';
            TableRelation = "Workplan Activities";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                /*IF NOT ("Account Type" IN ["Account Type"::Total,"Account Type"::"End-Total"]) THEN
                  FIELDERROR("Account Type");
                CALCFIELDS(Balance);*/

            end;
        }
        field(6; "Business Unit Filter"; Code[10])
        {
            Caption = 'Business Unit Filter';
            FieldClass = FlowFilter;
            TableRelation = "Business Unit";
        }
        field(7; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Stores the reference to the first global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(11; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(12; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(13; "Workplan Code"; Code[60])
        {
            TableRelation = Workplan."Workplan Code" WHERE(Blocked = CONST(false));
        }
        field(14; "Converted to Budget"; Boolean)
        {
        }
        field(15; "Strategic Plan Code"; Code[20])
        {

            trigger OnValidate()
            begin
                /*
                strategic.RESET;
                strategic.SETRANGE(strategic."Employee Code","Strategic Plan Code");
                IF Medium.FIND('-') THEN BEGIN
                  "Strategic Plan Desc":=FORMAT(strategic."Basic Pay");
                END
                */

            end;
        }
        field(16; "Strategic Plan Desc"; Text[100])
        {
        }
        field(17; "Medium term Plan Code"; Code[60])
        {

            trigger OnValidate()
            begin
                /*
                Medium.RESET;
                Medium.SETRANGE(Medium.Code,"Medium term Plan Code");
                IF Medium.FIND('-') THEN BEGIN
                  "Medium term  Plan Desc":=Medium.Description;
                END
                */

            end;
        }
        field(18; "Medium term  Plan Desc"; Text[100])
        {
        }
        field(19; "PC Code"; Code[60])
        {

            trigger OnValidate()
            begin
                /*
                PC.RESET;
                PC.SETRANGE(PC."PC Code","PC Code");
                IF PC.FIND('-') THEN BEGIN
                  "PC Name":=PC."PC Activities";
                END
                */

            end;
        }
        field(20; "PC Name"; Text[100])
        {
        }
        field(21; "Workplan Description"; Text[250])
        {
            CalcFormula = Lookup(Workplan."Workplan Description" WHERE("Workplan Code" = FIELD("Activity Code")));
            FieldClass = FlowField;
        }
        field(22; "Amount to Transfer"; Decimal)
        {
        }
        field(23; "Uploaded to Procurement Workpl"; Boolean)
        {
            Caption = 'Uploaded to Procurement Workplan';
        }
        field(24; "Date to Transfer"; Date)
        {

            trigger OnValidate()
            begin
                //Added to ensure that Dates to be transfered are within budetary Control Dates
                // IF "Date to Transfer" <> 0D THEN BEGIN
                //     BudgetControl.RESET;
                //     IF BudgetControl.GET THEN BEGIN
                //         //  MESSAGE(FORMAT("Date to Transfer" ));
                //         IF ("Date to Transfer" < BudgetControl."Current Budget Start Date") OR ("Date to Transfer" > BudgetControl."Current Budget End Date")
                //        THEN BEGIN
                //             ERROR(Text002, "Date to Transfer", BudgetControl."Current Budget Start Date", BudgetControl."Current Budget End Date");
                //         END;
                //     END;
                // END;
            end;
        }
        field(25; Description; Text[100])
        {
            Editable = false;
        }
        field(26; "Converted to Budget by:"; Text[100])
        {
        }
        field(35; Status; Option)
        {
            OptionMembers = Pending,"Pending Approval",Approved,Cancelled;
        }
        field(50000; "Default RFP Code"; Code[60])
        {
            TableRelation = "Procurement Methods";
        }
        field(50001; "Proc. Method No."; Code[20])
        {
            Caption = 'Procurement Method';
            TableRelation = "GRN Lines List Page";
        }
        field(50002; "Budgeted Amount"; Decimal)
        {
            CalcFormula = Sum("Workplan Entry".Amount WHERE("Activity Code" = FIELD("Activity Code")));
            Caption = 'Current Budgeted Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Quantity; Decimal)
        {
        }
        field(50004; "Expense Code"; Code[30])
        {
            TableRelation = "Expense Code".Code;
        }
        field(50005; "No."; Code[50])
        {
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Blocked" = CONST(false))
            // "Expense Code" = FIELD("Expense Code"))
            ELSE
            IF (Type = CONST(Item)) Item WHERE(Blocked = CONST(false))
            else
            IF (Type = CONST("Fixed Asset")) "Fixed Asset" WHERE(Blocked = CONST(false));

            trigger OnValidate()
            begin
                IF Type = Type::Item THEN BEGIN
                    Item.RESET;
                    IF Item.GET("No.") THEN BEGIN
                        Description := Item.Description;
                    END ELSE BEGIN
                        Description := '';
                    END;
                END;

                IF Type = Type::"G/L Account" THEN BEGIN
                    GLAccount.RESET;
                    IF GLAccount.GET("No.") THEN BEGIN
                        Description := GLAccount.Name;
                    END ELSE BEGIN
                        Description := '';
                    END;
                END;
            end;
        }
        field(50006; Type; Option)
        {
            OptionCaption = ' ,G/L Account,Item,Fixed Asset';
            OptionMembers = " ","G/L Account",Item,"Fixed Asset";
        }
        field(50007; "Budget Filter"; Code[10])
        {
        }
        field(50008; "Global Dimension 1 Filter"; Code[10])
        {
        }
        field(50009; "Global Dimension 2 Filter"; Code[10])
        {
        }
        field(50010; "Unit of Measure"; Option)
        {
            OptionMembers = "NO."," Pieces"," Litres"," Boxes"," Pax"," Reams";
        }
        field(50011; "Source Of Funds"; Option)
        {
            OptionMembers = GoK," Others";

        }
        field(50012; "category Sub Plan"; Option)
        {
            OptionMembers = " ",Youth," Women & PWDs"," General"," Restricted"," RFP";
        }
        field(50013; "Unit of Cost"; Decimal)
        {
        }
        field(50014; "Goods Required Date"; Date)
        {
        }
        field(50015; "Other Source of Funds"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Activity Code")
        {
        }
        key(Key2; "Shortcut Dimension 2 Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record "Item";
        GLAccount: Record "G/L Account";
        WorkplanActivities: Record "Workplan Activities";
        //BudgetControl: Record "FIN-Budgetary Control Setup";
        Text002: Label 'The current date [%1 ] does not fall within the Budget Dates. Current Budget Dates are between [%2 upto %3]';
}

