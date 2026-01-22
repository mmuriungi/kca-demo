page 52178573 "Proc-PreliminaryQualif.Qualify"
{
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Proc-Preliminary Qualif.Quote";
    SourceTableView = where("Quote Status" = filter(Preliminary));

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quote No."; Rec."Quote No.")
                {

                    DrillDownPageId = "Proc-Purchase Quote.Card";
                    Caption = 'Quote/Bid No.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No. field.';
                    trigger OnDrillDown()
                    var
                        Pheader: Record "Purchase Header";
                    begin
                        Pheader.Reset();
                        Pheader.SetRange("No.", rec."Quote No.");
                        if Pheader.Find('-') then
                            page.run(page::"Proc-Purchase Quote.Card", Pheader)
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Scored; Rec.Scored)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scored field.';
                    trigger OnValidate()
                    begin
                        if rec.Scored = rec.Scored::"Requirement Not Met" then Fieldeditable := true else Fieldeditable := false;
                    end;
                }
                field(Reason; Rec.Reason)
                {
                    Editable = Fieldeditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason field.';
                }

                field(Evaluated; Rec.Evaluated)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluated field.';
                }
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        if rec.Scored = rec.Scored::"Requirement Not Met" then Fieldeditable := true else Fieldeditable := false;
    end;

    trigger OnOpenPage()
    begin
        if rec.Scored = rec.Scored::"Requirement Not Met" then Fieldeditable := true else Fieldeditable := false;
    end;

    trigger OnClosePage()
    begin

        if (rec.Scored = rec.Scored::"Requirement Not Met") and (rec.Reason = '') then Error('Input a reason why the requirement has not been met');
    end;

    var
        Fieldeditable: Boolean;
        Pheader: Record "Purchase Header";
}