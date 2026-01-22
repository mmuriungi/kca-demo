pageextension 50031 CompanyInformation extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter("EORI Number")
        {
            field("Company P.I.N"; Rec."Company P.I.N")
            {
                ApplicationArea = All;

            }
            field("Delete from Date"; Rec."Delete from Date")
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}