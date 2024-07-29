page 51025 "HRM-Applicant Referees"
{
    PageType = List;
    SourceTable = "HRM-Applicant Referees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Names; Rec.Names)
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field(Institution; Rec.Institution)
                {
                }
                field(Address; Rec.Address)
                {
                }
                field("Telephone No"; Rec."Telephone No")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
            }
        }
    }

    actions
    {
    }
}

