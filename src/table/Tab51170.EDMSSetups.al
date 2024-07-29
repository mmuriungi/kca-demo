table 51170 "EDMS Setups"

{
    LookupPageId = SharePoint;
    DrillDownPageId = SharePoint;

    fields
    {
        field(1; "Ref No"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                date := Today;
                "Received By" := UserId;
            end;
        }

        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Document type"; Option)
        {
            OptionMembers = PV,"Imprest Surrender","Incoming Mail","Imprest Requisition",Memo,Receipt,Claim,"Petty Cash","Purchase Invoice","Purchase Credit Memo","Procurement Plan","Purchase Memo","Purchase Requisition","Purchase Quotes","Purchase Order","Indirect Process LPO NO","Tendering","Staff File","Training Card",Welfare,Disciplinary,Drivers,"Transport Requisition","Fuel Requisition","Students Applications","Institution Attachments","Reccurrent Application","Disbursment","Staff Data";
            DataClassification = ToBeClassified;
        }
        field(4; Url; Text[250])
        {
            Caption = 'Url';
            DataClassification = ToBeClassified;
        }
        field(5; date; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Received';
        }
        field(6; Media; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Mail Content"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "1st Comment"; text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "2nd Commend"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = '2nd Comment';
        }

        field(10; status; Option)
        {
            OptionMembers = Open,Pending,Approved,Cancelled;
            Editable = false;
        }
        field(11; "Incoming Mail"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Department; Code[50])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(13; "Received By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(pk; "Document type")
        {
            Clustered = true;
        }
    }

}
