page 52027 "Projects List"
{
    Caption = 'Contract List';
    ApplicationArea = All;
    CardPageID = "Project Header Card";
    Editable = false;
    PageType = List;
    SourceTable = "Project Header";
    SourceTableView = WHERE(Status = FILTER(Open | "Pending Approval"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Name';
                }
                field("Project Date"; Rec."Project Date")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Date';
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                    ApplicationArea = All;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = All;
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                    ApplicationArea = All;
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = All;
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ApplicationArea = All;
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

