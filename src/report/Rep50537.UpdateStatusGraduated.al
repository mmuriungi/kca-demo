report 50537 "Update Status Graduated"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/UpdateToGraduated.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {

            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(CustomerPostingGroup_Customer; "Customer Posting Group")
            {
            }
            column(CustomerType_Customer; "Customer Type")
            {
            }
            column(Status_Customer; Status)
            {
            }
            column(TaggedasGraduating_Customer; "Tagged as Graduating")
            {
            }
            column(GraduatingAcademicYear_Customer; "Graduating Academic Year")
            {
            }

            trigger OnAfterGetRecord()
            begin
                cust.Reset();
                cust.SetRange("No.", "No.");
                cust.SetRange("Customer Type", "Customer Type"::Student);
                cust.SetRange(Status, Status::Current);
                if cust.Find('-') then begin
                    repeat
                        cust.CalcFields("Tagged as Graduating");
                        if cust."Tagged as Graduating" = true then
                            cust.Status := cust.Status::"Graduated no Certificates";
                        cust.Modify();

                    until cust.Next() = 0;

                end;


            end;
        }


    }
    var
        Cust: Record Customer;
}