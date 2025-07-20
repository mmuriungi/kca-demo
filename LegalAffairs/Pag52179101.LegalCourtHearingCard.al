page 52179101 "Legal Court Hearing Card"
{
    PageType = Card;
    SourceTable = "Legal Court Hearing";
    Caption = 'Legal Court Hearing Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                    Editable = false;
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case number.';
                }
                field("Hearing Type"; Rec."Hearing Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing type.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing status.';
                }
            }
            
            group("Date & Time")
            {
                Caption = 'Date & Time';
                
                field("Hearing Date"; Rec."Hearing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing date.';
                }
                field("Hearing Time"; Rec."Hearing Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing time.';
                }
                field("Next Hearing Date"; Rec."Next Hearing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next hearing date.';
                }
            }
            
            group("Court Details")
            {
                Caption = 'Court Details';
                
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
            }
            
            group("Legal Representation")
            {
                Caption = 'Legal Representation';
                
                field("Legal Counsel Present"; Rec."Legal Counsel Present")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the legal counsel present.';
                    MultiLine = true;
                }
            }
            
            group(Outcome)
            {
                Caption = 'Outcome';
                
                field("Hearing Outcome"; Rec."Hearing Outcome")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hearing outcome.';
                    MultiLine = true;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Mark Completed")
            {
                ApplicationArea = All;
                Caption = 'Mark Completed';
                Image = Completed;
                ToolTip = 'Mark this hearing as completed.';
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Completed;
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
            action("Adjourn Hearing")
            {
                ApplicationArea = All;
                Caption = 'Adjourn Hearing';
                Image = PostOrder;
                ToolTip = 'Adjourn this hearing to a later date.';
                
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Adjourned;
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
        }
    }
}