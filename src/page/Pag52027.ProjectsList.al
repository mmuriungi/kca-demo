page 52027 "Projects List"
{
    Caption = 'Contract List';
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
                }
                field("Project Name"; Rec."Project Name")
                {
                    Caption = 'Contract Name';
                }
                field("Project Date"; Rec."Project Date")
                {
                    Caption = 'Contract Date';
                }
                field("Estimated Start Date"; Rec."Estimated Start Date")
                {
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                }
                field("Estimated Duration"; Rec."Estimated Duration")
                {
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                }
                field("Actual Duration"; Rec."Actual Duration")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

