page 52179085 "Foundation Scholar App List"
{
    PageType = List;
    SourceTable = "Foundation Scholarship App.";
    Caption = 'Foundation Scholarship Application List';
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Foundation Scholar App Card";
    
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
                field("Scholarship No."; Rec."Scholarship No.")
                {
                    ApplicationArea = All;
                }
                field("Scholarship Name"; Rec."Scholarship Name")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ApplicationArea = All;
                }
                field("GPA"; Rec."GPA")
                {
                    ApplicationArea = All;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                }
                field("Awarded Amount"; Rec."Awarded Amount")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
                    ScholarshipApp: Record "Foundation Scholarship App.";
                    ScholarAppCard: Page "Foundation Scholar App Card";
                begin
                    ScholarshipApp.Init();
                    ScholarAppCard.SetRecord(ScholarshipApp);
                    ScholarAppCard.Run();
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