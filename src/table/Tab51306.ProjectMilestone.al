table 51306 "Project Milestone"
{
    Caption = 'Project Milestone';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Project No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Header";
        }
        field(2; "Task No"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(3; Descriprion; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Responsible Person"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Assigned staffs"."Staff Number" where(no = field("Project No"));
        }
        field(5; "User ID"; Code[25])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(6; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Email,"Phone Call","Field Visit",Training,Meeting,"Report Preparation","Report Presentation",Other;
        }
        field(7; Importance; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Low,Moderate,High;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Started,Suspended,Finished,"Pending Approval",Approved,Rejected;

            trigger OnValidate()
            begin

            end;
        }
        field(9; "Progress Level %"; Decimal)
        {
            // CalcFormula = Sum("Project Task Components"."Progress Level" WHERE("Project No" = FIELD("Project No"),
            //                                                                     "Task No" = FIELD("Task No")));
            // FieldClass = FlowField;
        }
        field(10; "Task Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(11; "Estimated Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Estimated End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Actual Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Actual End date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; No; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Project No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Task No" = '' then begin
            EstateSetup.Get();
            EstateSetup.TestField("Project Task Nos");
            NoSeriesMgnt.InitSeries(EstateSetup."Project Task Nos", xRec."No. Series", Today, Rec."Task No", Rec."No. Series");
        end;
    end;

    var
        EstateSetup: Record "Estates Setup";
        NoSeriesMgnt: Codeunit NoSeriesManagement;
}
