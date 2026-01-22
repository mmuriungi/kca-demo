page 51524 "Utility Bills"
{
    Caption = 'Utility Bills';
    PageType = List;
    SourceTable = "Utility Bill";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(Creator; Rec.Creator)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creator field.';
                }
                field("Dept. Code"; Rec."Dept. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dept. Code field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field("Bill Type"; Rec."Bill Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;
    end;

    /*  trigger OnInsertRecord(NewRec: Boolean): Boolean
     var
         myInt: Integer;
     begin

     end; */
}
