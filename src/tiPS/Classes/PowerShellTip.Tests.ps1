BeforeAll {
	. "$PSScriptRoot\PowerShellTip.ps1"
}

Describe 'Validating a PowerShellTip' {
	Context 'Given a PowerShellTip has invalid properties' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.Id = "TipId"
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should throw an error when no ID is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Id = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when the CreatedDate has not been set' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.CreatedDate = [DateTime]::MinValue
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when the ID contains spaces' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Id = 'The ID should not contain spaces'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when no Title is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Title = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when no TipText is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.TipText = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when more than 3 URLs are supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com', 'https://Url3.com', 'https://Url4.com')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when a URL does not start with http:// or https://' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com', 'Url3.com')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when an invalid MinPowerShellVersion is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = 'Not a valid version'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when a version with a Build is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '5.1.1'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when a version with a Revision is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '5.1.0.1'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when an invalid Category is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			{ $tip.Category = 'InvalidCategory' } | Should -Throw
		}
	}

	Context 'Given a PowerShellTip has all valid properties' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.Id = "TipId"
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should not throw an error when all properties are valid' {
			[tiPS.PowerShellTip] $tip = $validTip
			{ $tip.Validate() } | Should -Not -Throw
		}

		It 'Should not throw an error when the MinPowerShellVersion is 0.0' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '0.0'
			{ $tip.Validate() } | Should -Not -Throw
		}

		It 'Should not throw an error when the MinPowerShellVersion is an empty string' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = ''
			{ $tip.Validate() } | Should -Not -Throw
		}
	}
}

Describe 'Checking if a MinPowerShellVersion was supplied' {
	Context 'Given a PowerShellTip has a MinPowerShellVersion' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.Id = "TipId"
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should return true when a MinPowerShellVersion is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '5.1'
			$tip.MinPowerShellVersionIsProvided | Should -BeTrue
		}
	}

	Context 'Given a PowerShellTip does not have a MinPowerShellVersion' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.Id = "TipId"
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '0.0'
			$validTip.Category = 'Community'
		}

		It 'Should return false when the MinPowerShellVersion is 0.0' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '0.0'
			$tip.MinPowerShellVersionIsProvided | Should -BeFalse
		}

		It 'Should return false when the MinPowerShellVersion is an empty string' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = ''
			$tip.MinPowerShellVersionIsProvided | Should -BeFalse
		}

		It 'Should return false when the MinPowerShellVersion is a whitespace string' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = ' '
			$tip.MinPowerShellVersionIsProvided | Should -BeFalse
		}
	}
}
