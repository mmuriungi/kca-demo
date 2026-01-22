report 50715 "Near Expirery  Batch Numbers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Near Expirery  Batch Numbers.rdl';
    Caption = 'stock take report';

    dataset
    {
        dataitem(PharmacyStockHeader; "Pharmacy Stock Header")
        {
            column(No; "No.")
            {
            }
            column(SequenceNo; SequenceNo)
            {
            }
            column(UserID; "User ID")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(DateandTime; "Date and Time")
            {
            }
            column(Description; Description)
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
            column(Posted; Posted)
            {
            }
            column(Status; Status)
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Reasonforadjustment; "Reason for adjustment")
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(BatchNumber; "Batch Number")
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
        st: Record "Pharmacy Stock Header";
}
