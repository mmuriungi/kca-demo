page 50464 "ACA-Applicant Qualifications"
{
    Caption = 'Applicant Qualifications';
    PageType = List;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HRM-Applicant Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = all;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Score ID"; Rec."Score ID")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Desired Score"; Rec."Desired Score")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

