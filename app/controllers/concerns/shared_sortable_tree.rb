module SharedSortableTree
  extend ActiveSupport::Concern

  included do
    include TheSortableTreeController::Rebuild
    ddd
  end

end