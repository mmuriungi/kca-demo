page 52093 "Quality Assurance Setup"
{
    ApplicationArea = All;
    Caption = 'Quality Assurance Setup';
    PageType = Card;
    SourceTable = "Quality Assurance Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Primary Key field.';
                    Visible = false;
                }
                field("Survey Nos."; Rec."Survey Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series code used to assign numbers to surveys.';
                }
                field("Evaluation Nos."; Rec."Evaluation Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series code used to assign numbers to evaluations.';
                }
                field("Question Nos."; Rec."Question Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series code used to assign numbers to questions.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert();
        end;
    end;
}
