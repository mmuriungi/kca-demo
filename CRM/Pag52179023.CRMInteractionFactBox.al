page 52147 "CRM Interaction FactBox"
{
    PageType = ListPart;
    Caption = 'Interaction History';
    SourceTable = "CRM Interaction Log";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(InteractionHistory)
            {
                field("Interaction Date"; Rec."Interaction Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                    ToolTip = 'Date of the interaction';
                }
                field("Interaction Type"; Rec."Interaction Type")
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    ToolTip = 'Type of interaction';
                }
                field("Subject"; Rec."Subject")
                {
                    ApplicationArea = All;
                    Caption = 'Subject';
                    ToolTip = 'Subject of the interaction';
                }
                field("Contact Method"; Rec."Contact Method")
                {
                    ApplicationArea = All;
                    Caption = 'Method';
                    ToolTip = 'Contact method used';
                }
                field("Outcome"; Rec."Outcome")
                {
                    ApplicationArea = All;
                    Caption = 'Outcome';
                    ToolTip = 'Outcome of the interaction';
                }
                field("Duration (Minutes)"; Rec."Duration (Minutes)")
                {
                    ApplicationArea = All;
                    Caption = 'Duration';
                    ToolTip = 'Duration in minutes';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'View Details';
                Image = View;
                ToolTip = 'View detailed information about this interaction';
                
                trigger OnAction()
                begin
                    Page.Run(Page::"CRM Interaction Card", Rec);
                end;
            }
            action(NewInteraction)
            {
                ApplicationArea = All;
                Caption = 'New Interaction';
                Image = New;
                ToolTip = 'Create a new interaction for this customer';
                
                trigger OnAction()
                var
                    InteractionLog: Record "CRM Interaction Log";
                begin
                    InteractionLog.Init();
                    InteractionLog."Customer No." := Rec."Customer No.";
                    InteractionLog."Interaction Date" := Today;
                    InteractionLog."Interaction Time" := Time;
                    Page.Run(Page::"CRM Interaction Card", InteractionLog);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Filter to show only interactions for the current customer
        Rec.SetCurrentKey("Customer No.", "Interaction Date");
        Rec.SetRange("Customer No.");
    end;
}
