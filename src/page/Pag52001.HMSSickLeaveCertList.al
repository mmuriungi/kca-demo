page 55000 "HMS Sick Leave Cert. List"
{
    PageType = List;
    SourceTable = "HMS-Off Duty";
    Caption = 'Sick Leave Certificates';
    CardPageId = "HMS Sick Leave Cert. Card";
    Editable = true;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Certificate No."; Rec."Certificate No.")
                {
                    ApplicationArea = All;
                    Caption = 'Certificate No.';
                }
                field("Certificate Date"; Rec."Certificate Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
                field("Treatment No."; Rec."Treatment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Treatment No.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Caption = 'Title';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field("PF No."; Rec."PF No.")
                {
                    ApplicationArea = All;
                    Caption = 'PF No.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
                field("Sick Leave Duration"; Rec."Sick Leave Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Duration';
                }
                field("Duration Unit"; Rec."Duration Unit")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                }
                field("Off Duty Start Date"; Rec."Off Duty Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("Review Date"; Rec."Review Date")
                {
                    ApplicationArea = All;
                    Caption = 'Review Date';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Caption = 'Created By';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("New Certificate")
            {
                Caption = 'New Certificate';
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                RunObject = Page "HMS Sick Leave Cert. Card";
                RunPageMode = Create;
            }
            
            action("Print Certificate")
            {
                Caption = 'Print Certificate';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SickLeaveRec: Record "HMS-Off Duty";
                begin
                    CurrPage.SetSelectionFilter(SickLeaveRec);
                    if SickLeaveRec.FindFirst() then
                        Report.Run(Report::"HMS Sick Leave Certificate", true, false, SickLeaveRec); 
                end;
            }
        }
        
        area(navigation)
        {
            action("View Certificate")
            {
                Caption = 'View Certificate';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page "HMS Sick Leave Cert. Card";
                RunPageLink = "Certificate No." = field("Certificate No.");
            }
        }
    }
}