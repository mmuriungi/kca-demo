page 50234 "Disposal Period"
{
    PageType = List;
    SourceTable = "Disposal Period";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Financial Year"; Rec."Financial Year")
                {
                }
                field("Previous Year"; Rec."Previous Year")
                {
                }
            }
        }
    }

    actions
    {
    }
}

