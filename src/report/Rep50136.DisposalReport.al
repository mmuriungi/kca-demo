report 50136 "Disposal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Disposal Report.rdlc';

    dataset
    {
        dataitem(DataItem1; "Disposal Header")
        {
            DataItemTableView = SORTING("Disposal Period", "No.");
            RequestFilterFields = "No.", "Disposal Period";
            column(Picture; CI.Picture)
            {
            }
            column(Name; CI.Name)
            {
            }
            column(Address; CI.Address)
            {
            }
            column(Address2; CI."Address 2")
            {
            }
            column(City; CI.City)
            {
            }
            column(PhoneNo; CI."Phone No.")
            {
            }
            column(EMail; CI."E-Mail")
            {
            }
            column(HomePage; CI."Home Page")
            {
            }
            column(No_DisposalHeader; "No.")
            {
            }
            column(Desciption_DisposalHeader; Desciption)
            {
            }
            column(DisposalMethod_DisposalHeader; "Disposal Method")
            {
            }
            column(Status_DisposalHeader; Status)
            {
            }
            column(DisposalStatus_DisposalHeader; "Disposal Status")
            {
            }
            column(Date_DisposalHeader; Date)
            {
            }
            column(Noseries_DisposalHeader; "No series")
            {
            }
            column(RefNo_DisposalHeader; "Ref No")
            {
            }
            column(ResponsibilityCenter_DisposalHeader; "Responsibility Center")
            {
            }
            column(Disposed_DisposalHeader; Disposed)
            {
            }
            column(Shortcutdimension2code_DisposalHeader; "Shortcut dimension 2 code")
            {
            }
            column(DisposalPlanNo_DisposalHeader; "Disposal Plan No.")
            {
            }
            column(Shortcutdimension1code_DisposalHeader; "Shortcut dimension 1 code")
            {
            }
            column(DisposalPeriod_DisposalHeader; "Disposal Period")
            {
            }
            dataitem(DataItem2; "Disposal Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Disposal Period", "Disposal Plan No.", "Line No.", "Item/Tag No")
                                    ORDER(Ascending);
                column(LineNo_DisposalLine; "Line No.")
                {
                }
                column(ItemTagNo_DisposalLine; "Item/Tag No")
                {
                }
                column(DisposalPlanNo_DisposalLine; "Disposal Plan No.")
                {
                }
                column(Description_DisposalLine; Description)
                {
                }
                column(UnitofMeasure_DisposalLine; "Unit of Measure")
                {
                }
                column(PlannedQuantity_DisposalLine; "Planned Quantity")
                {
                }
                column(ActualDisposalPrice_DisposalLine; "Actual Disposal Price")
                {
                }
                column(TotalPrice_DisposalLine; "Total Price")
                {
                }
                column(Date_DisposalLine; Date)
                {
                }
                column(Disposed_DisposalLine; Disposed)
                {
                }
                column(Shortcutdimension1code_DisposalLine; Department)
                {
                }
                column(Shortcutdimension2code_DisposalLine; County)
                {
                }
                column(DisposalMethods_DisposalLine; "Disposal Methods")
                {
                }
                column(ActualQuantity_DisposalLine; "Actual Quantity")
                {
                }
                column(DisposedTo_DisposalLine; "Disposed To")
                {
                }
                column(ReservedPrice_DisposalLine; "Reserved Price")
                {
                }
                column(Confirmed_DisposalLine; Confirmed)
                {
                }
                column(ConfirmedBy_DisposalLine; "Confirmed By")
                {
                }
                column(DisposalPeriod_DisposalLine; "Disposal Period")
                {
                }
                column(No_DisposalLine; No)
                {
                }
                column(SerialNo_DisposalLine; "Serial No")
                {
                }
                column(ConfirmationDate_DisposalLine; "Confirmation Date")
                {
                }
                column(Pic; CI.Picture)
                {
                }
            }
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

    trigger OnPreReport()
    begin
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CI: Record "Company Information";
}

