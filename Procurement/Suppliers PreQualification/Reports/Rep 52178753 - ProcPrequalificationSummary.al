report 52178753 "Proc-Prequalification Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Suppliers PreQualification/Reports/SSR/ProcPrequalificationSummary.rdl';
    dataset
    {
        dataitem(Year; "Proc-Prequalification Years")
        {
            CalcFields = "Preq. Categories";
            RequestFilterFields = "Preq. Year";
            column(PreqYear_Year; "Preq. Year")
            {
            }
            column(StartDate_Year; "Start Date")
            {
            }
            column(EndDate_Year; "End Date")
            {
            }
            column(PreqCategories_Year; "Preq. Categories")
            {
            }
            column(PreqDatesList_Year; "Preq. Dates List")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompMail; CompanyInformation."E-Mail")
            {
            }
            column(CompUrl; CompanyInformation."Home Page")
            {
            }
            column(CompLogo; CompanyInformation.Picture)
            {
            }
            dataitem(Cat; "Proc-Prequalif. Categories")
            {
                DataItemLink = "Preq Year" = field("Preq. Year");
                RequestFilterFields = "Category Code";
                column(PreqYear_Cat; "Preq Year")
                {
                }
                column(CategoryCode_Cat; "Category Code")
                {
                }
                column(Description_Cat; Description)
                {
                }
                dataitem(Supp; "Proc-Preq. Suppliers/Category")
                {

                    DataItemLink = "Preq. Year" = FIELD("Preq Year"), "Preq. Category" = field("Category Code");
                    CalcFields = Email, Phone, "Agpo Categorization";
                    RequestFilterFields = Supplier_Code, "Agpo Categorization";

                    column(PreqYear_Supp; "Preq. Year")
                    {
                    }
                    column(PreqCategory_Supp; "Preq. Category")
                    {
                    }
                    column(Supplier_Code_Supp; Supplier_Code)
                    {
                    }
                    column(SupplierName_Supp; "Supplier Name")
                    {
                    }
                    column(Phone_Supp; Phone)
                    {
                    }
                    column(Email_Supp; Email)
                    {
                    }
                    column(AgpoCategorization_Supp; "Agpo Categorization")
                    {
                    }
                    column(Phone2_Supp; "Phone 2")
                    {
                    }
                    column(Email2_Supp; "Email 2")
                    {
                    }
                    column(sno; sno)
                    {

                    }

                    trigger OnAfterGetRecord()
                    begin
                        sno := sno + 1;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    sno := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Year.CALCFIELDS("Preq. Categories");
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);
            end;

        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
        sno: Integer;
}

