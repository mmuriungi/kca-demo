page 50074 "Student Deferment/Withdrawals"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Deferment/Withdrawal";
    CardPageId = "Student Deferment/Withdrawal";
    Editable = false;
    Caption = 'Student Deferment/Withdrawal Requests';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the request number.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the student number.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the student name.';
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this is a deferment or withdrawal request.';
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the request was submitted.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date of the deferment or withdrawal.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the end date of the deferment. Leave blank for withdrawal.';
                    Visible = Rec."Request Type" = Rec."Request Type"::Deferment;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year for the request.';
                }
                field("Semester"; Rec."Semester")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the semester for the request.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the request.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewRequest)
            {
                ApplicationArea = All;
                Caption = 'New Request';
                Image = NewDocument;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Create a new deferment or withdrawal request.';
                RunObject = Page "Student Deferment/Withdrawal";
                RunPageMode = Create;
            }
        }
    }
}
