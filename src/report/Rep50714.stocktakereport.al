report 50714 "stock take report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/stock take report.rdl';
    Caption = 'stock take report';
    dataset
    {
        dataitem(PharmacyItems; "Item")
        {
            column(No; "No.")
            {
            }
            column(SequenceNo; "SequenceNo")
            {
            }
            column(Company_Name; info.Name)
            {
            }
            column(Company_Picture; info.Picture)
            {
            }
            column(Company_email; info."E-Mail")
            {
            }
            column(Description; Description)
            {
            }
            column(Unitofmeasure; "Unit of measure")
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(DrugCategory; "Drug Category")
            {
            }
            column(UnitCost; "Unit Cost")
            {
            }
            column(ReorderThreshold; "Reorder Threshold")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        if info.get() then
            info.CalcFields(Picture);


        myInt := 1;

        // Iterate through the dataset and assign sequence numbers
        if st.FindSet() then
            repeat
                st.SequenceNo := myInt;
                st.Modify();
                myInt := myInt + 1;
            until st.Next() = 0;

    end;

    var
        info: Record "Company Information";
        st: Record Item;
}
