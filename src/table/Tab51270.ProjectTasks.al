table 51270 "Project Tasks"
{
    Caption = 'Contract';
    DrillDownPageID = "Project Tasks";
    LookupPageID = "Project Tasks";

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
                if "Task No" <> xRec."Task No" then begin
                    NoSeriesManagement.TestManual(ProcSetup."Task Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(3; Descriprion; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Responsible Person"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Project Team"."ID No" WHERE("Project No" = FIELD("Project No"));
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
                if Status = Status::Started then begin
                    Project.Get("Project No");
                    Project.TestField("Estimated Start Date");
                    if Project."Actual Start Date" = 0D then begin
                        Project."Actual Start Date" := Today;
                        Project.Modify;
                    end;
                end;
            end;
        }
        field(9; "Progress Level %"; Decimal)
        {
            CalcFormula = Sum("Project Task Components"."Progress Level" WHERE("Project No" = FIELD("Project No"),
                                                                                "Task No" = FIELD("Task No")));
            FieldClass = FlowField;
        }
        field(10; "Task Budget"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Project.Reset;
                Project.SetRange("No.", "Project No");
                if Project.FindFirst then begin
                    TaskBudget := "Task Budget";
                    ProjectTasks.Reset;
                    ProjectTasks.SetRange("Project No", "Project No");
                    ProjectTasks.SetFilter("Task No", '<>%1', "Task No");
                    if ProjectTasks.FindFirst then
                        repeat
                            TaskBudget += ProjectTasks."Task Budget";
                        until ProjectTasks.Next = 0;
                    if Project."Project Budget" < TaskBudget then
                        Error('You have exceeded project %1 budget by %2', "Project No", TaskBudget - Project."Project Budget");
                end;
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
        key(Key1; "Project No", "Task No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        ProcSetup.Get;
        if "Task No" = '' then begin
            ProcSetup.TESTFIELD("Task Nos");
            NoSeriesManagement.InitSeries(ProcSetup."Task Nos", xRec."No. Series", 0D, "Task No", "No. Series");
        end;

        "User ID" := UserId;
    end;

    var
        Project: Record "Project Header";
        ProjectTasks: Record "Project Tasks";
        TaskBudget: Decimal;
        ProcSetup: Record "Purchases & Payables Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
}

