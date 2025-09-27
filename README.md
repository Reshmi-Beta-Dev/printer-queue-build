# Print Queue Monitor

A Windows service application that automatically monitors the print queue and saves print jobs along with their metadata to local disk storage.

## Features

- **Automatic Print Queue Monitoring**: Continuously monitors Windows print queue for new jobs
- **File Saving**: Saves print job data to configurable output directory
- **Metadata Extraction**: Captures comprehensive job information including user, printer, timing, and document details
- **Multiple Formats Support**: Handles various print formats (PDF, TXT, DOC, DOCX, XPS, PS, etc.)
- **Configurable Settings**: JSON-based configuration for all settings
- **Windows Service**: Can run as a background Windows service
- **Console Mode**: Also supports console mode for testing and debugging
- **Event Logging**: Integrated with Windows Event Log
- **Error Handling**: Robust error handling and retry mechanisms

## Requirements

- Windows 10/11 or Windows Server 2016+
- .NET 6.0 Runtime
- Administrator privileges (for service installation)

## Installation

### Option 1: Install as Windows Service (Recommended)

1. Open Command Prompt as Administrator
2. Navigate to the project directory
3. Run: `install-service.bat`
4. The service will be installed and started automatically

### Option 2: Run in Console Mode

1. Open Command Prompt
2. Navigate to the project directory
3. Run: `run-console.bat`

## Configuration

Edit `appsettings.json` to customize the application behavior:

```json
{
  "PrintQueueSettings": {
    "OutputDirectory": "C:\\PrintQueueJobs",
    "PollingIntervalSeconds": 5,
    "MaxRetries": 3,
    "RetryDelaySeconds": 10,
    "SaveRawData": true,
    "SaveMetadata": true,
    "MetadataFormat": "json",
    "FileNamingPattern": "{timestamp}_{jobId}_{printerName}",
    "SupportedFormats": [".pdf", ".txt", ".doc", ".docx", ".xps", ".ps"],
    "EnableEventLogging": true,
    "LogLevel": "Information"
  }
}
```

### Configuration Options

- **OutputDirectory**: Directory where print jobs will be saved
- **PollingIntervalSeconds**: How often to check for new print jobs
- **MaxRetries**: Maximum retry attempts for failed operations
- **RetryDelaySeconds**: Delay between retry attempts
- **SaveRawData**: Whether to save the actual print job data
- **SaveMetadata**: Whether to save job metadata as JSON
- **MetadataFormat**: Format for metadata files (currently only JSON)
- **FileNamingPattern**: Pattern for naming saved files
- **SupportedFormats**: List of supported file extensions
- **EnableEventLogging**: Enable Windows Event Log integration
- **LogLevel**: Logging level (Debug, Information, Warning, Error)

## File Naming

Files are saved using the pattern specified in `FileNamingPattern`. Available placeholders:
- `{timestamp}`: Current date/time (yyyyMMdd_HHmmss)
- `{jobId}`: Print job ID
- `{printerName}`: Printer name (sanitized for file system)

Example: `20241201_143022_123_HP_LaserJet.pdf`

## Output Structure

```
C:\PrintQueueJobs\
├── 20241201_143022_123_HP_LaserJet.pdf
├── 20241201_143022_123_HP_LaserJet_metadata.json
├── 20241201_143025_124_Canon_Printer.txt
└── 20241201_143025_124_Canon_Printer_metadata.json
```

## Metadata Format

Each print job generates a metadata JSON file containing:

```json
{
  "JobId": 123,
  "JobName": "Document1",
  "PrinterName": "HP LaserJet",
  "UserName": "john.doe",
  "MachineName": "WORKSTATION01",
  "SubmittedTime": "2024-12-01T14:30:22",
  "StartedTime": "2024-12-01T14:30:23",
  "CompletedTime": "2024-12-01T14:30:25",
  "Pages": 1,
  "PagesPrinted": 1,
  "Size": 1024,
  "Status": "Completed",
  "DocumentName": "Document1.pdf",
  "DataType": "PDF",
  "FileExtension": ".pdf",
  "SavedFilePath": "C:\\PrintQueueJobs\\20241201_143022_123_HP_LaserJet.pdf",
  "ProcessedAt": "2024-12-01T14:30:25",
  "FileSize": 1024
}
```

## Service Management

### Start Service
```cmd
sc start PrintQueueMonitor
```

### Stop Service
```cmd
sc stop PrintQueueMonitor
```

### Uninstall Service
Run `uninstall-service.bat` as Administrator

## Troubleshooting

### Check Service Status
```cmd
sc query PrintQueueMonitor
```

### View Event Logs
1. Open Event Viewer
2. Navigate to Windows Logs > Application
3. Look for entries from "PrintQueueMonitor"

### Common Issues

1. **Service won't start**: Ensure .NET 6.0 Runtime is installed
2. **Permission denied**: Run installation script as Administrator
3. **No files saved**: Check output directory permissions and configuration
4. **High CPU usage**: Increase PollingIntervalSeconds in configuration

## Development

### Building from Source
```cmd
dotnet build --configuration Release
```

### Running Tests
```cmd
dotnet run --configuration Release
```

## Security Considerations

- The application requires administrator privileges to access print queue information
- Output directory should have appropriate permissions
- Consider encrypting sensitive print job data if required
- Monitor disk space usage for the output directory

## License

This software is provided as-is for commercial use. No copyright restrictions apply.

## Support

For ongoing support and updates, contact the development team.

