/**
 * Initialize searchable/sortable shortcut tables
 * Uses List.js for filtering and sorting
 * Compatible with MkDocs Material instant loading
 */

// Wait for MkDocs Material's instant loading to complete
document$.subscribe(function() {
  initShortcutTables();
});

function initShortcutTables() {
  // Find all elements with .shortcuts-table class
  const tables = document.querySelectorAll('.shortcuts-table');

  tables.forEach((container, index) => {
    // Skip if already initialized
    if (container.classList.contains('shortcuts-initialized')) {
      return;
    }

    // Get the table element
    const table = container.querySelector('table');
    if (!table) return;

    // Extract column names from header
    const headers = table.querySelectorAll('th');
    const valueNames = Array.from(headers).map((th, i) => {
      // Use data-sort attribute if present, otherwise use index
      return th.getAttribute('data-sort') || `col-${i}`;
    });

    // Add classes to table cells for List.js
    const rows = table.querySelectorAll('tbody tr');
    rows.forEach(row => {
      const cells = row.querySelectorAll('td');
      cells.forEach((cell, i) => {
        if (valueNames[i]) {
          cell.classList.add(valueNames[i]);
        }
      });
    });

    // Add list class to tbody
    const tbody = table.querySelector('tbody');
    tbody.classList.add('list');

    // Create search input if not exists
    let searchInput = container.querySelector('.search');
    if (!searchInput) {
      searchInput = document.createElement('input');
      searchInput.className = 'search';
      searchInput.placeholder = 'Search shortcuts...';
      searchInput.type = 'text';
      container.insertBefore(searchInput, table);
    }

    // Initialize List.js
    const options = {
      valueNames: valueNames,
      searchClass: 'search',
      listClass: 'list'
    };

    new List(container, options);

    // Mark as initialized
    container.classList.add('shortcuts-initialized');

    // Add sorting to headers
    headers.forEach((th, i) => {
      th.classList.add('sort');
      th.setAttribute('data-sort', valueNames[i]);
    });
  });

  // Log initialization
  console.log(`Initialized ${tables.length} shortcut tables`);
}

// Fallback for non-instant loading
if (typeof document$ === 'undefined') {
  document.addEventListener('DOMContentLoaded', initShortcutTables);
}
