page 51041 "Aca-Charge Addition"
{
    PageType = Document;
    SourceTable = "Aca-Charge Addition";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(general)
            {
                Editable = false;
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Document date"; Rec."Document date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document date field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            group("Reg Details")
            {
                Editable = Editability;
                ShowCaption = false;

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Term; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Term field.';
                }
            }
            group("Line Details")
            {
                Editable = Editability;
                ShowCaption = false;
                part(Lines; "Aca-Charge Addition Lines")
                {
                    ApplicationArea = All;
                    SubPageLink = "Document No." = field("No.");
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post Charge")
            {
                Visible = Editability;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Confirm('Post This ?', true) = false then Error('Cancelled');
                    Rec.PostCharge(Rec);
                    CurrPage.Close();

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        EnableEdit();
    end;

    var
        Editability: Boolean;

    procedure EnableEdit()
    begin
        Editability := true;
        if rec.Posted = true then
            Editability := false;

    end;
}