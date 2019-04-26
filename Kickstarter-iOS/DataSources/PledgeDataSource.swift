import Foundation
import KsApi
import Library

final class PledgeDataSource: ValueCellDataSource {
  enum Section: Int {
    case project
    case inputs
    case summary
  }

  func load(amount: Double, currency: String, isLoggedIn: Bool) {
    self.appendRow(
      value: "Description",
      cellClass: PledgeRowCell.self,
      toSection: Section.project.rawValue
    )

    self.appendRow(
      value: (amount, currency),
      cellClass: PledgeAmountCell.self,
      toSection: Section.inputs.rawValue
    )

    self.appendRow(
      value: "Your shipping location",
      cellClass: PledgeRowCell.self,
      toSection: Section.inputs.rawValue
    )

    self.loadSummarySection(isLoggedIn: isLoggedIn)
  }

  private func loadSummarySection(isLoggedIn: Bool) {
    self.appendRow(
      value: "Total",
      cellClass: PledgeRowCell.self,
      toSection: Section.summary.rawValue
    )

    if isLoggedIn {
      self.appendRow(value: (),
                     cellClass: PledgeContinueCell.self,
                     toSection: Section.summary.rawValue)
    } else {
      // Load credit card / Apple Pay cells
    }
  }

  override func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
    switch (cell, value) {
    case let (cell as PledgeRowCell, value as String):
      cell.configureWith(value: value)
    case let (cell as PledgeAmountCell, value as (Double, String)):
      cell.configureWith(value: value)
    case let (cell as PledgeContinueCell, value as ()):
      cell.configureWith(value: value)
    default:
      assertionFailure("Unrecognized (cell, viewModel) combo.")
    }
  }
}
