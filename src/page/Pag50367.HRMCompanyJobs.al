page 50367 "HRM-Company Jobs"
{
    PageType = Document;
    SourceTable = "HRM-Company Jobs";

    layout
    {
        area(content)
        {
            field("Job ID"; Rec."Job ID")
            {
            }
            field("Job Description"; Rec."Job Description")
            {
            }
            field("Position Reporting to"; Rec."Position Reporting to")
            {
            }
            field("Dimension 1"; Rec."Dimension 1")
            {
            }
            field("Dimension 2"; Rec."Dimension 2")
            {
            }
            field(Department; Rec.Department)
            {
            }
            field(Category; Rec.Category)
            {
            }
            field(Grade; Rec.Grade)
            {
            }
            field(Objective; Rec.Objective)
            {
                Caption = 'Objective/Function';
                MultiLine = true;
            }
            field("No of Posts"; Rec."No of Posts")
            {
            }
            field("Occupied Position"; Rec."Occupied Position")
            {
            }
            field("Vacant Posistions"; Rec."Vacant Posistions")
            {
                Caption = 'Vacant Positions';
                Editable = false;
            }
            field("Key Position"; Rec."Key Position")
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {

                Caption = 'Job';
                action("Position Supervised")
                {
                    ApplicationArea = all;
                    Caption = 'Position Supervised';
                    RunObject = Page "HRM-J. Position Supervised";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Job Specification")
                {
                    ApplicationArea = all;
                    Caption = 'Job Specification';
                    RunObject = Page "HRM-J. Specification";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Key Responsibilities")
                {
                    ApplicationArea = all;
                    Caption = 'Key Responsibilities';
                    RunObject = Page "HRM-J. Responsiblities";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                action("Working Relationships")
                {
                    ApplicationArea = all;
                    Caption = 'Working Relationships';
                    RunObject = Page "HRM-J. Working Relationships";
                    RunPageLink = "Job ID" = FIELD("Job ID");
                }
                separator(Separator1000000025)
                {
                }
                action("Vacant Positions")
                {
                    ApplicationArea = all;
                    Caption = 'Vacant Positions';
                    RunObject = Page "HRM-Vacant Positions";
                }
                action("Over Staffed Positions")
                {
                    ApplicationArea = all;
                    Caption = 'Over Staffed Positions';
                    RunObject = Page "HRM-Over Staffed Positions";
                }
            }
        }
        area(processing)
        {
            action(Preview)
            {
                Caption = 'Preview';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Jobs.Reset;
                    Jobs.SetRange(Jobs."Job ID", Rec."Job ID");
                    if Jobs.Find('-') then
                        REPORT.RunModal(report::Jobs, true, false, Jobs);
                end;
            }
        }
    }

    var
        Jobs: Record "HRM-Company Jobs";
}

