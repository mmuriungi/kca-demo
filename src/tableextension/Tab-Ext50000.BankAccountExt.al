tableextension 50000 "Bank Account Ext" extends "Bank Account"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Bank Type"; Option)
        {
            Caption = 'Bank Type';
            OptionCaption = 'Normal,Cash,Fixed Deposit,SMPA,Chq Collection';
            OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection";
        }
        field(56602; "Receipt No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        // field(50000; "Bank Type"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = Normal,Cash,"Fixed Deposit",SMPA,"Chq Collection";

        //     trigger OnValidate()
        //     begin

        //         //TestNoEntriesExist(FIELDCAPTION("Bank Type"));
        //     end;
        // }
        field(50001; "Pending Voucher Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin


            end;
        }
        field(50003; "Bank Branch Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Last Pv No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        // field(50005; "Receipt No. Series"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "No. Series".Code;
        // }
        field(61002; "Credit Agreement?"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF NOT "Credit Agreement?" THEN "Maximum Credit Limit" := 0;
            end;
        }
        field(61003; "Maximum Credit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TESTFIELD("Credit Agreement?", TRUE);

                IF "Maximum Credit Limit" > 0 THEN
                    ERROR('Maximum Credit Limit must be less than zero');
            end;
        }
        field(61004; "Show on"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Payments Summary,Cash Summary';
            OptionMembers = " ","Payments Summary","Cash Summary";
        }
        field(61005; Abbreviation; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(61006; "Summary Reports"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Both,Receipts Only,Payments Only';
            OptionMembers = " ",Both,"Receipts Only","Payments Only";
        }
    }


}