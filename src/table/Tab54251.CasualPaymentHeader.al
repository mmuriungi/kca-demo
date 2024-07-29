table 54251 "Casual Payment Header."
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Salary Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(3; "Salary Acc Name"; Code[100])
        {
        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            Editable = false;
            InitValue = "G/L ACCOUNT";
            OptionCaption = 'G/L ACCOUNT';
            OptionMembers = "G/L ACCOUNT";
        }
        field(5; "P.A.Y.E Acc"; Code[20])
        {
            Caption = 'P.A.Y.E Acc';
            TableRelation = IF ("Account Type" = CONST("G/L ACCOUNT")) "G/L Account";
        }
        field(6; Payee; Text[50])
        {
        }
        field(7; "Total Basic Amount"; Decimal)
        {
            CalcFormula = Sum("Casual Payment Lines."."Basic Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Posting Date"; Date)
        {
        }
        field(11; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(12; Posted; Boolean)
        {
            Editable = true;
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; Remarks; Text[30])
        {
        }
        field(15; "Cheque No."; Code[20])
        {
        }
        field(16; "Cheque Date"; Date)
        {
        }
        field(17; "Total To Pay"; Decimal)
        {
            CalcFormula = Sum("Casual Payment Lines."."Basic Amount" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(18; "Payment Method"; Code[10])
        {
            TableRelation = "Payment Method".Code;
        }
        field(50000; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,GLJournal,Item Journal,Phys. Inventory Journal,FAJournal,Petty Cash,Advance,IOU,User (Store) Requisition,Store Manifest,Non-Conforming Products,Cooler Allocation,FA Reclass. Journal,Purchase Requisition,PayVoucher,Leave';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",GLJournal,"Item Journal","Phys. Inventory Journal",FAJournal,"Petty Cash",Advance,IOU,"User (Store) Requisition","Store Manifest","Non-Conforming Products","Cooler Allocation","FA Reclass. Journal","Purchase Requisition",PayVoucher,Leave;
        }
        field(50001; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Action';
            OptionMembers = Open,Released,"Pending Approval","Pending Action";
        }
        field(50002; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
        }
        field(50003; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(50004; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(50050; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
        }
        field(50051; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50052; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50053; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50054; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(50055; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(50056; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(50057; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(50058; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(50059; WTAXPosted; Boolean)
        {
        }
        field(50060; "Total PAYE"; Decimal)
        {
            CalcFormula = Sum("Casual Payment Lines."."PAYE Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50061; "Net Payable"; Decimal)
        {
            CalcFormula = Sum("Casual Payment Lines."."Net Pay" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50062; "Total NHIF"; Decimal)
        {
            CalcFormula = Sum("Casual Payment Lines."."NHIF Amount" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50063; "Total NSSF"; Decimal)
        {
            CalcFormula = Sum("Casual Payment Lines."."NSSF Amount" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50064; "NSSF Account"; Code[20])
        {
            Caption = 'NSSF Account';
            TableRelation = IF ("Account Type" = CONST("G/L ACCOUNT")) "G/L Account";
        }
        field(50065; NHIFAccount; Code[20])
        {
            Caption = 'NHIF Account';
            TableRelation = IF ("Account Type" = CONST("G/L ACCOUNT")) "G/L Account";
        }
        field(50066; "Salaries&Wages A/c"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50067; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "PRL-Payroll Periods"."Date Opened";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text064: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text003: Label 'Payment Voucher No. %1 is already posted';
        Text002: Label 'There are no lines to post';
        Text001: Label 'You cannot suggest lines for Payment Voucher No %1. It is already posted';
        Err100: Label 'VAT can only be specified for G/L Expense items';
        Err200: Label 'The VAT specified %1 has a value of zero';
        Text1000: Label 'Do you want to post this PV, Only lines marked as ''Invoice To Pay'' will be posted';
        Err000: Label 'An error occured while trying to send the PV for approval';
}

