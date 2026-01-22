page 52179079 "Foundation Grant App. List"
{
    PageType = List;
    SourceTable = "Foundation Grant Application";
    Caption = 'Foundation Grant Application List';
    UsageCategory = Lists;
    ApplicationArea = All;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Grant No."; Rec."Grant No.")
                {
                    ApplicationArea = All;
                }
                field("Project Title"; Rec."Project Title")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                }
            }
        }
        
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(NewApplication)
            {
                ApplicationArea = All;
                Caption = 'New Application';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                
                trigger OnAction()
                var
                    GrantApp: Record "Foundation Grant Application";
                begin
                    GrantApp.Init();
                    GrantApp.Insert(true);
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::"Under Review";
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec."Review Date" := WorkDate();
                    Rec."Reviewed By" := UserId;
                    Rec.Modify();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::"Under Review";
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    Rec."Review Date" := WorkDate();
                    Rec."Reviewed By" := UserId;
                    Rec.Modify();
                end;
            }
        }
    }
}