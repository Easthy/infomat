<?php
class Templater {
    protected $_file;
    protected $_data = array();

    public function __construct($file = null)
    {
        $this->_file = $file;
    }

    public function set_param($key, $value)
    {
        $this->_data[$key] = $value;
        return $this;
    }

    public function set_params($a)
    {
        foreach ($a as $key => $value) {
            $this->_data[$key] = $value;
        }
        return $this;
    }

    public function get_content()
    {
        $template = file_get_contents($this->_file);
        if (preg_match_all("/{{(.*?)}}/", $template, $m)) {
            foreach ($m[1] as $i => $varname) {
                $template = str_replace($m[0][$i], sprintf('%s', $this->_data[$varname]), $template);
            }
        }
        return $template;
    }
}