page 52179100 "Legal Court Hearing List"
{
    PageType = List;
    SourceTable = "Legal Court Hearing";
    Caption = 'Legal Court Hearing List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Legal Court Hearing Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case number.';
                }
                field("Hearing Date"; Rec."Hearing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing date.';
                    StyleExpr = DateStyle;
                }
                field("Hearing Time"; Rec."Hearing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing time.';
                }
                field("Hearing Type"; Rec."Hearing Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing type.';
                }
                field("Court Room"; Rec."Court Room")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the court room.';
                }
                field("Presiding Judge"; Rec."Presiding Judge")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the presiding judge.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing status.';
                    StyleExpr = StatusStyle;
                }
                field("Next Hearing Date"; Rec."Next Hearing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next hearing date.';
                }
                field("Legal Counsel Present"; Rec."Legal Counsel Present")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the legal counsel present.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("New Hearing")
            {
                ApplicationArea = All;
                Caption = 'New Hearing';
                Image = New;
                ToolTip = 'Create a new court hearing.';
                RunPageMode = Create;
                RunObject = page "Legal Court Hearing Card";
            }
            action("Mark Completed")
            {
                ApplicationArea = All;
                Caption = 'Mark Completed';
                Image = Completed;
                ToolTip = 'Mark the hearing as completed.';
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Completed;
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;
    
    local procedure SetStyles()
    begin
        DateStyle := 'Standard';
        StatusStyle := 'Standard';
        
        if Rec."Hearing Date" = Today then
            DateStyle := 'Attention'
        else if Rec."Hearing Date" < Today then
            DateStyle := 'Subordinate'
        else if Rec."Hearing Date" <= Today + 7 then
            DateStyle := 'Favorable';
            
        case Rec.Status of
            Rec.Status::Completed:
                StatusStyle := 'Favorable';
            Rec.Status::Cancelled:
                StatusStyle := 'Subordinate';
            Rec.Status::Adjourned:
                StatusStyle := 'Attention';
        end;
    end;
    
    var
        DateStyle: Text;
        StatusStyle: Text;
}